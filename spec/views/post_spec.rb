require './spec/spec_helper'

describe Views::Post do
  let(:post) {
    instance_double(
      'Post',
      id: 1,
      map_text: '',
      title: '',
      pp_created_at: '',
      tags: [],
    )
  }
  let(:item_hash) { { 1 => instance_double('Item') } }

  it 'should render' do
    view = Views::Post.new post: post, item_hash: item_hash
    expect(view.to_html).not_to be_nil
  end
end
