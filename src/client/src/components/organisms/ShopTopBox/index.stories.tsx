import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ShopTopBox from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "organisms/ShopTopBox",
	component: ShopTopBox,
} as ComponentMeta<typeof ShopTopBox>;

const Template: ComponentStory<typeof ShopTopBox> = (args) => (
	<ShopTopBox {...args}>{args.children}</ShopTopBox>
);

export const Default = Template.bind({});
Default.args = {
	luxaryActivateState: false,
	filteredCategory: "",
	onApplyFilter: action("filtered"),
};

export const Activated = Template.bind({});
Activated.args = {
	luxaryActivateState: true,
	filteredCategory: "의류",
	onApplyFilter: action("filtered"),
};
