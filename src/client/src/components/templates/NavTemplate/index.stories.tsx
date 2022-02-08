import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import NavTemplate from ".";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";

export default {
	title: "templates/NavTemplate",
	component: NavTemplate,
} as ComponentMeta<typeof NavTemplate>;

const Template: ComponentStory<typeof NavTemplate> = (args) => (
	<NavTemplate {...args}>{args.children}</NavTemplate>
);

export const Default = Template.bind({});
Default.args = {
	headerTop: <HeaderTop />,
	headerMain: <HeaderMain />,
	children: (
		<h1
			style={{
				display: "flex",
				margin: "300px auto",
				justifyContent: "center",
				alignItems: "center",
			}}
		>
			Home screen
		</h1>
	),
	footer: <Footer />,
};
