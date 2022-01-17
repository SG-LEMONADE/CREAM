import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import Footer from ".";

export default {
	title: "organisms/Footer",
	component: Footer,
} as ComponentMeta<typeof Footer>;

const Template: ComponentStory<typeof Footer> = (args) => (
	<Footer {...args}>{args.children}</Footer>
);

export const Default = Template.bind({});
Default.args = {};
