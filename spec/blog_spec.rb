require 'spec_helper'

describe Hypem::Blog do
  context "when initialized with a single string argument" do
    let(:blog) do
      Hypem::Blog.new(4632)
    end

    specify { blog.id.should == 4632 }

    it "converts strings to integers" do
      Hypem::Blog.new('4632').id.should === 4632
    end

    describe "#get_info" do
      subject do
        VCR.use_cassette('blog') {blog.get_info}
      end
      specify {subject.should be_a Hypem::Blog}
      specify {subject.site_name.should == 'Pasta Primavera'}
      specify {subject.blog_image.should == 'http://static-ak.hypem.net/images/blog_images/4632.jpg'}
      specify {subject.blog_image_small.should == 'http://static-ak.hypem.net/images/blog_images/small/4632.jpg'}
      specify {subject.site_url.should == 'http://pastaprima.net'}
      specify {subject.total_tracks.should be_an Integer}
      specify {subject.first_posted.should be_a DateTime}
      specify {subject.last_posted.should be_a DateTime}
      specify {subject.followers.should be_an Integer}

    end

    describe ".all" do
      subject { VCR.use_cassette('blog_all') { described_class.all } }
      it { should be_an Array }
      its(:first) { should be_a described_class }
    end
  end

end
