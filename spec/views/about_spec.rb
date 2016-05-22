require './spec/spec_helper'

describe Views::About do
  it 'should render' do
    view = Views::About.new
    expect(view.to_html).not_to be_nil
  end
end
