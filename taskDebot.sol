pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "../base/Debot.sol";
import "../base/Terminal.sol";
import "../base/Menu.sol";
import "../base/AddressInput.sol";
import "../base/ConfirmInput.sol";
import "../base/Upgradable.sol";
import "../base/Sdk.sol";

struct Task{
    uint32 id;
    string name;
    string text;
    uint8 priority;
    address creator;
    uint8 value;
    uint64 timestamp;
    string status;
    uint8 minNumDevReview;
    address assigned;
    uint8 evaluate; 
}


abstract contract ATask {
   constructor(uint256 pubkey) public {}
}

interface ITask {
   function createTask( string name, string text) external;
   function getTasks() external returns (Task[] tasks);
}

interface Itransactable {
	function sendTransaction(address dest, uint128 value, bool bounce, uint8 flags, TvmCell payload) external;
}

contract TaskDebot is Debot, Upgradable {
    bytes _icon;
    TvmCell _taskCode;
    TvmCell _taskData;
    TvmCell _taskStateInit; 
    address _address;  

    uint256 _masterPubKey; // User pubkey
    address _msigAddress;  // User wallet address

    string _thisTask;  

    uint32 INITIAL_BALANCE =  200000000;


    function setTaskCode(TvmCell code, TvmCell data) public {
        require(msg.pubkey() == tvm.pubkey(), 101);
        tvm.accept();
        _taskCode = code;
        _taskData = data;
        _taskStateInit = tvm.buildStateInit(_taskCode, _taskData);
    }

    function onSuccess() public {
        _menu();
    }

    function onError(uint32 sdkError, uint32 exitCode) public {
        Terminal.print(0, format("Operation failed. sdkError {}, exitCode {}", sdkError, exitCode));
        _menu();
    }

    function start() public override {
        Terminal.input(tvm.functionId(savePublicKey),"Please enter your public key",false);
    }

    function savePublicKey(string value) public {
        (uint res, bool status) = stoi("0x"+value);
        if (status) {
            _masterPubKey = res;

            Terminal.print(0, "Checking if you already have a Task list ...");
            TvmCell deployState = tvm.insertPubkey(_taskStateInit, _masterPubKey);
            _address = address.makeAddrStd(0, tvm.hash(deployState));
            Terminal.print(0, format( "Info: your Task contract address is {}", _address));
            Sdk.getAccountType(tvm.functionId(checkStatus), _address);

        } else {
            Terminal.input(tvm.functionId(savePublicKey),"Wrong public key. Try again!\nPlease enter your public key",false);
        }
    }


    /// @notice Returns Metadata about DeBot.
    function getDebotInfo() public functionID(0xDEB) override view returns(
        string name, string version, string publisher, string key, string author,
        address support, string hello, string language, string dabi, bytes icon
    ) {
        name = "Task DeBot";
        version = "0.2.0";
        publisher = "Working together";
        key = "Task list manager";
        author = "Working together";
        support = address(0);
        hello = "Hi, i'm a Task DeBot.";
        language = "en";
        dabi = m_debotAbi.get();
        icon = _icon;
    }

    function getRequiredInterfaces() public view override returns (uint256[] interfaces) {
        return [ Terminal.ID, Menu.ID, AddressInput.ID, ConfirmInput.ID ];
    }


    function checkStatus(int8 acc_type) public {
        if (acc_type == 1) { // acc is active and  contract is already deployed
            _menu();

        } else if (acc_type == -1)  { // acc is inactive
            Terminal.print(0, "You don't have a Task list yet, so a new contract with an initial balance of 0.2 tokens will be deployed");
            AddressInput.get(tvm.functionId(creditAccount),"Select a wallet for payment. We will ask you to sign two transactions");

        } else  if (acc_type == 0) { // acc is uninitialized
            Terminal.print(0, format(
                "Deploying new contract. If an error occurs, check if your Task contract has enough tokens on its balance"
            ));
            deploy();

        } else if (acc_type == 2) {  // acc is frozen
            Terminal.print(0, format("Can not continue: account {} is frozen", _address));
        }
    }

    function creditAccount(address value) public {
        _msigAddress = value;
        optional(uint256) pubkey = 0;
        TvmCell empty;
        Itransactable(_msigAddress).sendTransaction{
            abiVer: 2,
            extMsg: true,
            sign: true,
            pubkey: pubkey,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(waitBeforeDeploy),
            onErrorId: tvm.functionId(onErrorRepeatCredit) 
        }(_address, 2 ton, false, 3, empty);
    }

    function onErrorRepeatCredit(uint32 sdkError, uint32 exitCode) public { 
        sdkError;
        exitCode;
        creditAccount(_msigAddress);
    }


    function waitBeforeDeploy() public  {
        Sdk.getAccountType(tvm.functionId(checkIfStatusIs0), _address);
    }

    function checkIfStatusIs0(int8 acc_type) public {
        if (acc_type ==  0) {
            deploy();
        } else {
            waitBeforeDeploy();
        }
    }


    function deploy() private view {
            TvmCell image = tvm.insertPubkey(_taskStateInit, _masterPubKey);
            optional(uint256) none;
            TvmCell deployMsg = tvm.buildExtMsg({
                abiVer: 2,
                dest: _address,
                callbackId: tvm.functionId(onSuccess),
                onErrorId:  tvm.functionId(onErrorRepeatDeploy),    // Just repeat if something went wrong
                time: 0,
                expire: 0,
                sign: true,
                pubkey: none,
                stateInit: image,
                call: {ATask, _masterPubKey}
            });
            tvm.sendrawmsg(deployMsg, 1);
    }


    function onErrorRepeatDeploy(uint32 sdkError, uint32 exitCode) public view {
        sdkError;
        exitCode;
        deploy();
    }


    function _menu() private {
        string sep = '----------------------------------------';
        Menu.select(
            format(
                "You have tasks"
            ),
            sep,
            [
                MenuItem("Create new task","",tvm.functionId(addTaskName)),
                MenuItem("Show task list","",tvm.functionId(showTasks))
            ]
        );
    }

    function addTaskName() public {
        Terminal.input(tvm.functionId(addTaskText), "Enter name task:", false);
    }

    function addTaskText(string value) public {
        _thisTask = value;
        Terminal.input(tvm.functionId(createTask_), "Enter text task:", false);
    }

    function createTask_(string value) public view {
        optional(uint256) pubkey = 0;
        ITask(_address).createTask{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(_thisTask, value);
    }

    function showTasks() public view {
        optional(uint256) none;
        ITask(_address).getTasks{
            abiVer: 2,
            extMsg: true,
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(showTasks_),
            onErrorId: 0
        }();
    }

    function showTasks_( Task[] tasks ) public {
        uint32 i;
        if (tasks.length > 0 ) {
            Terminal.print(0, "Task list:");
            for (i = 0; i < tasks.length; i++) {
                Task task = tasks[i];
                Terminal.print(0, format("Task ID: {}", task.id));
				Terminal.print(0, format("Task Name: {}", task.name));
				Terminal.print(0, format("Task Text: {}", task.text));
                Terminal.print(0, format("Task Status: {}", task.status));
				Terminal.print(0, "------");
            }
        } else {
            Terminal.print(0, "Tasks list is empty");
        }
        _menu();
    }


    function onCodeUpgrade() internal override {
        tvm.resetStorage();
    }
}