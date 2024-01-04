return {
	s("dd", t("debugger")),

	s("clog", fmt('console.log("{}")', i(1))),

	s("td", fmt("TODO (martin) {} {}", {  i(1), i(2) })),

	s(
		"gjsc",
		fmt(
			[[
import Component from "@glimmer/component";
import {{ inject as service }} from "@ember/service";

export default class $1 extends Component {{
  @service currentUser;

  <template>
    {}
  </template>
}}
  ]],
			{ i(1) }
		)
	),
}
