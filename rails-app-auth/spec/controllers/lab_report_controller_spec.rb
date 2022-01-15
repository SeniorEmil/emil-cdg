require 'rails_helper'

RSpec.describe LabReportsController, type: :controller do
  let(:user) { create :user }
  let(:params) { { user_id: user } }

  describe '#index' do
    subject { get :index, params: params }

    let!(:lab_report) { create :lab_report, user: user }

    it 'assigns @LabReports' do
      subject
      expect(assigns(:lab_reports)).to eq([lab_report])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#new' do
    subject { get :new, params: params }

    it { is_expected.to render_template(:new) }

    it 'assigns new lab_report' do
      subject
      expect(assigns(:lab_report)).to be_a_new LabReport
    end
  end

  describe '#edit' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :edit, method: :get, params: params }

    it { is_expected.to render_template(:edit) }

    it 'assigns server policy' do
      subject
      expect(assigns :lab_report).to eq lab_report
    end
  end

  describe '#update' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user, lab_report: { title: 'Some title' } } }

    subject { process :update, method: :put, params: params }

    it 'updates lab_report' do
      expect { subject }.to change { lab_report.reload.title }.to('Some title')
    end

    context 'with bad params' do
      let(:params) { { id: lab_report, user_id: user, lab_report: { title: '' } } }

      it 'does not update lab_report' do
        expect { subject }.not_to change { lab_report.reload.title }
      end
    end
  end

  describe '#show' do
    let(:params) { { user_id: user.id, id: lab_report } }

    subject { get :show, params: params }

    let!(:lab_report) { create :lab_report, user: user }

    it 'assigns @lab_report' do
      subject
      expect(assigns(:lab_report)).to eq(lab_report)
    end

    it { is_expected.to render_template(:show) }
  end

  describe '#destroy' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :destroy, method: :delete, params: params }

    it 'delete post' do
      expect { subject }.to change { LabReport.count }.by(-1)
    end
  end

  describe '#mark' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :mark, method: :get, params: params }

    it { is_expected.to render_template(:mark) }

    it 'assigns server policy' do
      subject
      expect(assigns :lab_report).to eq lab_report
    end
  end
end
