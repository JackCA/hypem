require 'spec_helper'

describe Hypem::Blog do
  context "when initialized with a single string argument" do
    let(:blog) do
      Hypem::Blog.new(4632)
    end

    it "is successfully initialized" do
      blog.should be_a Hypem::Blog
    end

    it "sets id attribute" do
      blog.id.should == 4632
    end

    it "converts strings to integers" do
      Hypem::Blog.new('4632').id.should === 4632
    end

    describe "#get_info" do
      subject do
        VCR.use_cassette('blog') {blog.tap(&:get_info)}
      end
      specify {subject.should be_a Hypem::Blog}
      specify {subject.site_name.should == 'Pasta Primavera'}
      specify {subject.blog_image.should == 'http://static-ak.hypem.net/images/blog_images/4632.jpg'}
      specify {subject.blog_image_small.should == 'http://static-ak.hypem.net/images/blog_images/small/4632.jpg'}
      specify {subject.site_url.should == 'http://pastaprima.net'}
      specify {subject.total_tracks.should == 4026}
      specify {subject.first_posted.should be_a Time}
      specify {subject.last_posted.should be_a Time}
      specify {subject.followers.should == 1345}

      it "caches its response" do
        subject
        Hypem::Request.should_not_receive :new
        VCR.use_cassette('blog') { blog.get_info }
      end

    end
  end

end
