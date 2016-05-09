require './spec/spec_helper'

describe Views::Nav do
  let(:links) { [['Home', '/home']] }

  it 'should render' do
    view = Views::Nav.new links: links
    expect(view.to_html).not_to be_nil
  end
end
