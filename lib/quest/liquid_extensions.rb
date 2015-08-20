require 'rouge'

class Tip < Liquid::Block
    def render(context)
        "<div class = \"lvm-callout lvm-tip\"><p>#{super}</p></div>"
    end
end

class Warning < Liquid::Block
    def render(context)
        "<div class = \"lvm-callout lvm-warning\"><p>#{super}</p></div>"
    end
end

class Fact < Liquid::Block
    def render(context)
        "<div class = \"lvm-callout lvm-fact\"><p>#{super}</p></div>"
    end
end

class Aside < Liquid::Block
  def initialize(tag_name, markup, tokens)
    super
    @title = markup
  end
  def render(context)
    @context = context
    "<div class = \"lvm-inline-aside\"><h4>#{@title}</h4><p>#{Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(super)}</p></div>"
  end
end

class Figure < Liquid::Tag
  def initialize(tag_name, text, tokens)
     super
     @src = text
  end
    def render(context)
        "<div class = \"img-wrapper\"><img src=#{@src}/></div>"
    end
end

class Task < Liquid::Block
  def initialize(tag_name, markup, tokens)
     super
     @number = markup
  end

    def render(context)
        "<div class = \"lvm-task-number\"><p>Task #{@number}:</p></div>"
    end
end

class Highlight < Liquid::Block
  @@formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
  @@lexer = Rouge::Lexers::Puppet.new
  def render(context)
    @@formatter.format(@@lexer.lex(super))
  end
end

Liquid::Template.register_tag('task', Task)
Liquid::Template.register_tag('tip', Tip)
Liquid::Template.register_tag('warning', Warning)
Liquid::Template.register_tag('fact', Fact)
Liquid::Template.register_tag('aside', Aside)
Liquid::Template.register_tag('figure', Figure)
Liquid::Template.register_tag('highlight', Highlight)
