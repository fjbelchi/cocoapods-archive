require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Archive do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ archive }).should.be.instance_of Command::Archive
      end
    end
  end
end

