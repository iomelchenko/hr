require 'spec_helper'
require 'rails_helper'

describe Skill do

	describe 'Skills ' do	
		it { should validate_presence_of :name}
	end	

end