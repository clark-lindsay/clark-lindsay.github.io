import Config

config :temple,
  engine: EEx.SmartEngine,
  attributes: {Temple, :attributes}

config :tableau, :reloader,
  patterns: [
    ~r"lib/layouts/.*.ex",
    ~r"lib/pages/.*.ex",
    ~r"lib/components.ex",
    ~r"_site/.*.css"
  ]

config :tailwind,
  version: "3.3.5",
  default: [
    args: ~w(
    --config=assets/tailwind.config.js
    --input=assets/css/site.css
    --output=_site/css/site.css
    )
  ]

config :tableau, :assets, tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}

config :tableau, :config,
  url: "http://localhost:4999",
  timezone: "America/Detroit",
  markdown: [
    mdex: [
      extension: [header_ids: "", tasklist: true, strikethrough: true],
      render: [unsafe_: true],
      features: [syntax_highlight_theme: "kanagawa"]
    ]
  ]

config :tableau, Tableau.PostExtension,
  enabled: true,
  future: true

config :tableau, Tableau.PageExtension,
  enabled: true,
  permalink: "/pages/:title"

config :tableau, Tableau.RSSExtension,
  enabled: true,
  title: "Clark Lindsay",
  description: "An engineer with opinions, and maybe some ideas, maybe even about software."

config :elixir, :time_zone_database, Tz.TimeZoneDatabase

import_config "#{config_env()}.exs"
