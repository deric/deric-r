require 'spec_helper'

describe 'r' do
  shared_examples 'a Linux OS' do
    it { should compile.with_all_deps }
    it { should contain_class('r') }
  end

  context 'Debian OS' do
    it_behaves_like 'a Linux OS' do
      let :facts do
        {
          :operatingsystem => 'Debian',
          :osfamily => 'debian',
          :lsbdistcodename => 'wheezy',
          :lsbdistid => 'debian',
        }
      end

      it { should contain_package('r-base') }

      context 'enable apt repository' do
        let(:params) {{
          :manage_repo => true,
        }}

        it { should contain_apt__source('r-project') }
      end

    end
  end
end