require 'rails_helper'

RSpec.describe Users::Filters::SpecificUsers, type: :model do
  let(:instance) { described_class.new users: users }

  let!(:conn_1) { FactoryGirl.create :connection }
  let!(:conn_2) { FactoryGirl.create :connection }

  describe '#execute' do
    let(:users) { [conn_1.target.mkey, conn_2.target.mkey, 'xxxxxxxxxxxxxxxxxxxx'] }
    subject { instance.execute }

    it do
      is_expected.to match_array [
        {
          'id'            => conn_1.target.id,
          'mkey'          => conn_1.target.mkey,
          'connection_id' => conn_1.id,
          'time_zero'     => conn_1.created_at.change(usec: 0),
          'invitee'       => conn_1.target.name,
          'inviter'       => conn_1.creator.name
        }, {
          'id'            => conn_2.target.id,
          'mkey'          => conn_2.target.mkey,
          'connection_id' => conn_2.id,
          'time_zero'     => conn_2.created_at.change(usec: 0),
          'invitee'       => conn_2.target.name,
          'inviter'       => conn_2.creator.name
        }
      ]
    end
  end
end
