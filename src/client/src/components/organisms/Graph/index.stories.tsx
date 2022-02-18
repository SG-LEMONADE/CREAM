import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Graph from ".";

export default {
	title: "organisms/Graph",
	component: Graph,
} as ComponentMeta<typeof Graph>;

const Template: ComponentStory<typeof Graph> = (args) => (
	<Graph {...args}>{args.children}</Graph>
);

export const AllSize = Template.bind({});
AllSize.args = {
	graphData: [
		{
			date: "2022-01-27",
			price: 122000,
		},
		{
			date: "2022-01-28",
			price: 141000,
		},
		{
			date: "2022-02-01",
			price: 145000,
		},
		{
			date: "2022-02-05",
			price: 150000,
		},
		{
			date: "2022-02-16",
			price: 134000,
		},
		{
			date: "2022-02-28",
			price: 100000,
		},
		{
			date: "2022-03-04",
			price: 104000,
		},
	],
};

export const Size = Template.bind({});
Size.args = {
	graphData: [
		{
			date: "2022-01-27",
			price: 122000,
		},
		{
			date: "2022-01-28",
			price: 141000,
		},
		{
			date: "2022-02-01",
			price: 145000,
		},
		{
			date: "2022-02-05",
			price: 150000,
		},
		{
			date: "2022-02-16",
			price: 134000,
		},
		{
			date: "2022-02-28",
			price: 100000,
		},
		{
			date: "2022-03-04",
			price: 104000,
		},
	],
	size: "240",
};

export const NoData = Template.bind({});
NoData.args = {
	graphData: [],
};
