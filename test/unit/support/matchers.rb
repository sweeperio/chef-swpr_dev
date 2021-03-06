# these already exists upstream, just not released yet
def install_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :install, resource_name)
end

def install_with_make_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :install_with_make, resource_name)
end

def cherry_pick_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :cherry_pick, resource_name)
end
