#
# Cookbook Name:: swpr_dev
# Spec:: _shell
#
# The MIT License (MIT)
#
# Copyright (c) 2016 sweeper.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

describe "swpr_dev::_shell" do
  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set["swpr_dev"]["vagrant_shell"] = "zsh"
    end

    runner.converge(described_recipe)
  end

  it "converges successfully" do
    expect { chef_run }.to_not raise_error
  end

  it "installs zsh" do
    expect(chef_run).to install_package("zsh")
  end

  it "creates the default zshenv file" do
    expect(chef_run).to create_cookbook_file("/etc/zsh/zshenv").with(source: "zshenv")
  end

  it "sets the default shell for vagrant" do
    expect(chef_run).to run_execute("set vagrant shell").with(
      command: "chsh -s $(which zsh) vagrant"
    )
  end
end
