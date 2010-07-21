use inc::Module::Install;
name 'Class-Operator';
all_from 'lib/Class/Operator.pm';

# requires '';


readme_markdown_from 'lib/Class/Operator.pm';
tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests('xt');
# use_test_base;
auto_include;
WriteAll;
