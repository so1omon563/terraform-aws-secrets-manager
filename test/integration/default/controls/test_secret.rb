# frozen_string_literal: true

include_controls 'inspec-aws'
require './test/library/common'

tfstate = get_state
secret_id = tfstate['outputs']['secret']['value']['secret']['id'].to_s

control 'default' do
  describe aws_secretsmanager_secret(secret_id: secret_id) do
    # https://github.com/inspec/inspec-aws/blob/main/docs/resources/aws_secretsmanager_secret.md
    it { should exist }
    its('rotation_enabled') { should eq nil }
    its('kms_key_id') { should eq nil }
  end
end
