require './spec/spec_helper'

describe Views::Posts do
  let(:items) { [instance_double('Item')] }

  let(:posts) { [ instance_double('Post')] }

  it 'should render' do
    expect(Views::Posts.new(items: items, posts: posts)).not_to be_nil
  end
end
