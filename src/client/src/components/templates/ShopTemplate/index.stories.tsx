import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ShopTemplate from ".";

export default {
	title: "templates/ShopTemplate",
	component: ShopTemplate,
} as ComponentMeta<typeof ShopTemplate>;

const Template: ComponentStory<typeof ShopTemplate> = (args) => (
	<ShopTemplate {...args}>{args.children}</ShopTemplate>
);

export const Default = Template.bind({});
Default.args = {};
