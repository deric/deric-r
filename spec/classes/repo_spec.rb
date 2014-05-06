require 'spec_helper'

describe 'r::repo' do

  shared_examples 'debian' do |operatingsystem, lsbdistcodename, release|
    let(:facts) {{
      :operatingsystem => operatingsystem,
      :osfamily => 'Debian',
      :lsbdistcodename => lsbdistcodename,
      :lsbdistid => operatingsystem,
    }}

    it { should contain_apt__source('r-project').with(
     'location' => "http://cran.r-project.org/bin/linux/#{operatingsystem.downcase}",
     'repos'    => '',
     'release'  => "#{release}/"
    )}

    context "manage_repo => false" do
      let(:params) {{ :manage_repo => false }}
      it { should_not contain_apt__source('r-project') }
    end
  end

  context 'debian' do
    it_behaves_like 'debian', 'Debian', 'wheezy', 'wheezy-cran3'
    it_behaves_like 'debian', 'Ubuntu', 'precise', 'precise'
  end

end
