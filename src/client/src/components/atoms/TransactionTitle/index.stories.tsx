import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TransactionTitle from ".";

export default {
	title: "atoms/TransactionTitle",
	component: TransactionTitle,
} as ComponentMeta<typeof TransactionTitle>;

const Template: ComponentStory<typeof TransactionTitle> = (args) => (
	<TransactionTitle {...args}>{args.children}</TransactionTitle>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
};
