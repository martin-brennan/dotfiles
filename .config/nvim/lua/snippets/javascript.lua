return {
	s("dd", t("debugger")),

	s("pt", t("pauseTest();")),

	s("clog", fmt("console.log({});", i(1))),

	s("td", fmt("TODO (martin) {} {}", { i(1), i(2) })),

	s(
		"gjsc",
		fmt(
			[[
import Component from "@glimmer/component";
import {{ inject as service }} from "@ember/service";

export default class {} extends Component {{
  @service currentUser;

  <template>
    {}
  </template>
}}
  ]],
			{ i(1), i(2) }
		)
	),

	s(
		"ts",
		fmt(
			[[
       test("{}", async function (assert) {{
         {}
       }});
       ]],
			{ i(1), i(2) }
		)
	),

	s(
		"comptest",
		fmt(
			[[
import {{ render }} from "@ember/test-helpers";
import {{ hbs }} from "ember-cli-htmlbars";
import {{ module, test }} from "qunit";
import {{ setupRenderingTest }} from "discourse/tests/helpers/component-test";

module("Integration | Component | {}", function (hooks) {{
  setupRenderingTest(hooks);

  test("preview updates with markdown", async function (assert) {{
    // await render(hbs`<DEditor @value={{{{this.value}}}} />`);
    {}
  }});
}});
  ]],
			{ i(1), i(2) }
		)
	),
}
