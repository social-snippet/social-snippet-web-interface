require "spec_helper"

describe ::Completer::Application::Helpers, :current => true do

  let(:helpers) do
    ::Class.new do
      include ::Completer::Application::Helpers
    end.new
  end

  describe "#new_ranges" do

    subject { helpers.new_ranges src, dest }

    context "change single line" do

      let(:src) do
        [
          "hello",
        ].join($/)
      end

      let(:dest) do
        [
          "world",
        ].join($/)
      end

      let(:expected) do
        { :from => 0, :to => 0 }
      end

      it { should include expected }

    end # single line

    context "not change" do

      let(:src) do
        [
          "hello",
        ].join($/)
      end

      let(:dest) do
        [
          "hello",
        ].join($/)
      end

      it { should be_empty }

    end # single line without change

    context "single range" do

      let(:src) do
        [
          "#include <iostream>",
          "using namespace std;",
          "",
          "// @snip <path/to/func.cpp>",
          "",
          "int main() {",
          "  cout << \"func() = \" << func() << endl;",
          "  return 0;",
          "}",
        ].join($/)
      end

      let(:dest) do
        [
          "#include <iostream>",
          "using namespace std;",
          "",
          "// @snippet <path/to/func.cpp>",
          "int func() {",
          "  return 42;",
          "}",
          "",
          "int main() {",
          "  cout << \"func() = \" << func() << endl;",
          "  return 0;",
          "}",
        ].join($/)
      end

      let(:expected) do
        { :from => 3, :to => 6 }
      end

      it { should include expected }

    end # single range

    context "multi ranges" do

      let(:src) do
        [
          "#include <iostream>",
          "using namespace std;",
          "",
          "// @snippet <path/to/func1.cpp>",
          "int func1() {",
          "  return 1;",
          "}",
          "",
          "// comment",
          "",
          "// @snippet <path/to/func2.cpp>",
          "int func2() {",
          "  return 2;",
          "}",
          "",
          "// comment",
          "",
          "// @snippet <path/to/func3.cpp>",
          "int func3() {",
          "  return 3;",
          "}",
          "",
          "// comment",
          "",
          "int main() {",
          "  return 0;",
          "}",
        ].join($/)
      end

      let(:dest) do
        [
          "#include <iostream>",
          "using namespace std;",
          "",
          "// @snippet <path/to/func1.cpp>",
          "int new_func1() {",
          "  return 1;",
          "}",
          "",
          "// comment",
          "",
          "// @snippet <path/to/func2.cpp>",
          "int new_func2() {",
          "  return 2;",
          "}",
          "",
          "// comment",
          "",
          "// @snippet <path/to/func3.cpp>",
          "int new_func3() {",
          "  return 3;",
          "}",
          "",
          "// comment",
          "",
          "int main() {",
          "  return 0;",
          "}",
        ].join($/)
      end

      context "include? 4-4" do
        let(:expected) do
          { :from => 4, :to => 4 }
        end
        it { should include expected }
      end

      context "include? 11-11" do
        let(:expected) do
          { :from => 11, :to => 11 }
        end
        it { should include expected }
      end

      context "include? 18-18" do
        let(:expected) do
          { :from => 18, :to => 18 }
        end
        it { should include expected }
      end

      context "inversed args" do

        subject { helpers.new_ranges dest, src }

        context "include? 4-4" do
          let(:expected) do
            { :from => 4, :to => 4 }
          end
          it { should include expected }
        end

        context "include? 11-11" do
          let(:expected) do
            { :from => 11, :to => 11 }
          end
          it { should include expected }
        end

        context "include? 18-18" do
          let(:expected) do
            { :from => 18, :to => 18 }
          end
          it { should include expected }
        end

      end # inversed args

    end # multi ranges

  end

end # ::Completer::Application::Helpers

