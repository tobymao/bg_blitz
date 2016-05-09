require_relative '../spec_helper'

describe Views::Page do
  it 'should render' do
    expect(Views::Page.new).not_to be_nil
  end
end
