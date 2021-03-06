require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "functions returning :strptr" do
  it "can attach function with :strptr return type" do
    lambda do
      m = Module.new do
        extend FFI::Library
        ffi_lib FFI::Library::LIBC
        attach_function :strdup, [ :string ], :strptr
      end
    end.should_not raise_error
  end

  module StrPtr
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    attach_function :strdup, [ :string ], :strptr
    attach_function :free, [ :pointer ], :void
  end

  it "should return [ String, Pointer ]" do
    result = StrPtr.strdup("test")
    result[0].is_a?(String).should be_true
    result[1].is_a?(FFI::Pointer).should be_true
  end

  it "should return the correct value" do
    result = StrPtr.strdup("test")
    result[0].should == "test"
  end

  it "should return non-NULL pointer" do
    result = StrPtr.strdup("test")
    result[1].null?.should be_false
  end
end