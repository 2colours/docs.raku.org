use Documentable::Search;

sub init-search($host) is export {
    my $search-generator = Documentable::Search.new(prefix => $host.config.url-prefix);
    my @items = $search-generator.generate-entries($host.registry);
    my $template-path = 'templates/search_template.js';
    my $template = slurp($template-path);
    $template = $template.subst("ITEMS", @items.join(",\n"))
            .subst("WARNING", "DO NOT EDIT generated by $?FILE:$?LINE");
    spurt 'static/js/search.js', $template;
}

sub generate-categories is export {
    # An alphabetic sorting here? Or maybe semantic sorting?
    ["Adverbs", "Asynchronous Phasers", "Circumfix operators", "Control flow", "Other languages",
     "Infix operators", "Language", "List operators", "Listop operators", "Metaoperators",
     "Methods", "Modules", "Operators", "Phasers", "Postcircumfix operators", "Postfix operators",
     "Pragmas", "Prefix operators", "Programs", "Reference", "Regexes", "Routines", "Subroutines",
     "Syntax", "Terms", "Traits", "Tutorial", "Types", "Variables"]
}
