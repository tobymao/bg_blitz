require './spec/spec_helper'

describe Views::Contact do
  it 'should render' do
    view = Views::Contact.new
    expect(view.to_html).not_to be_nil
  end
end
