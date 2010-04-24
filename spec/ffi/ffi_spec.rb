require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "FFI" do

  describe ".map_library_name" do

    let(:prefix) { FFI::Platform::LIBPREFIX }
    let(:suffix) { FFI::Platform::LIBSUFFIX }
    
    it "should add platform library extension if not present" do
      FFI.map_library_name("#{prefix}dummy").should == "#{prefix}dummy.#{suffix}"
    end

    it "should add platform library extension even if lib suffix is present in name" do
      FFI.map_library_name("#{prefix}dummy_with_#{suffix}").should == "#{prefix}dummy_with_#{suffix}.#{suffix}"
    end

  end

end
