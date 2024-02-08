return {
	s("dd", t("binding.pry")),

	s("pt", t("pause_test")),

	s("clog", fmt('puts "{}"', i(1))),

	s("fzs", t("# frozen_string_literal: true")),

	s("irrev", t("raise ActiveRecord::IrreversibleMigration")),

	s("td", { t("# TODO (martin) "), i(1) }),

	s(
		"itsh",
		fmt(
			[[
  it "{}" do
    {}
  end
  ]],
			{ i(1), i(2) }
		)
	),

	s(
		"dsc",
		fmt(
			[[
  describe "{}" do
    {}
  end
  ]],
			{ i(1), i(2) }
		)
	),

	s(
		"ctx",
		fmt(
			[[
  context "{}" do
    {}
  end
  ]],
			{ i(1), i(2) }
		)
	),

	s(
		"befdo",
		fmt(
			[[
  before do
    {}
  end
  ]],
			i(1)
		)
	),

	s(
		"classspec",
		fmt(
			[[
      # frozen_string_literal: true

      RSpec.describe {} do
        {}
      end
    ]],
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		"sql",
		fmt(
			[[
      sql_query = <<~SQL
        {}
      SQL
      DB.exec(sql_query, {})
    ]],
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		"sysspec",
		fmt(
			[[
      # frozen_string_literal: true

      describe "{}", type: :system, js: true do
        fab!(:current_user) {{ Fabricate(:user) }}

        before do
          sign_in(current_user)
        end

        it "works" do
          {}
        end
      end
    ]],
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		"job",
		fmt(
			[[
      # frozen_string_literal: true

      module Jobs
        class {} < Jobs::Base
          def execute(args)
          end
        end
      end
    ]],
			{
				i(1),
			}
		)
	),
}
