import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import SearchFilterBar from ".";

export default {
	title: "organisms/SearchFilterBar",
	component: SearchFilterBar,
} as ComponentMeta<typeof SearchFilterBar>;

const Template: ComponentStory<typeof SearchFilterBar> = (args) => (
	<SearchFilterBar {...args}>{args.children}</SearchFilterBar>
);

export const Default = Template.bind({});
Default.args = {
	setBrandId: {},
	luxaryFilter: false,
	//setLuxaryFilter: ,
	filteredCategory: "sneakers",
	//setFilteredCategory: () => void,
	filteredBrand: ["adidas"],
	//setFilteredBrand: () => void,
	filteredCollections: [],
	// setFilteredCollections,
	filteredGender: "여성",
	// setFilteredGender,
	filteredPrice: "10만원 이하",
	// setFilteredPrice,
};
