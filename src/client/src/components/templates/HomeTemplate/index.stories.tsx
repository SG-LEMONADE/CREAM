import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import HomeTemplate from ".";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";

export default {
	title: "templates/HomeTemplate",
	component: HomeTemplate,
} as ComponentMeta<typeof HomeTemplate>;

const Template: ComponentStory<typeof HomeTemplate> = (args) => (
	<HomeTemplate {...args}>{args.children}</HomeTemplate>
);

export const Default = Template.bind({});
Default.args = {
	headerTop: <HeaderTop />,
	headerMain: <HeaderMain />,
	children: <h1>Home screen</h1>,
	footer: <Footer />,
};
