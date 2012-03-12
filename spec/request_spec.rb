require 'hypem'

describe Hypem::Request do
  it "makes get requests" do
    response = Hypem::Request.get('/playlist/latest/fresh')
    response.should_not be_nil
    response.should_not be_empty

  end

end
