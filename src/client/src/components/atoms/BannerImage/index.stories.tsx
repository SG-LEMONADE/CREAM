import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import BannerImage from ".";

export default {
	title: "atoms/BannerImage",
	component: BannerImage,
} as ComponentMeta<typeof BannerImage>;

const Template: ComponentStory<typeof BannerImage> = (args) => (
	<BannerImage {...args}>{args.children}</BannerImage>
);

export const Big = Template.bind({});
Big.args = {
	bgColor: "rgb(185, 145, 237)",
	category: "big",
	src: "https://kream-phinf.pstatic.net/MjAyMjAxMDdfMjE1/MDAxNjQxNTQ0MjY5MjMx.sh8EkefwZTj77UkKMisov1eV3KGnAmSQjd4Nuc6TtaEg.-xyxjm-rcxWLSQL4COdO6WfsEsxnMKjf0s8INeazuEwg.PNG/a_17eb39b3028c4925a156ccde317e851e.png?type=m_2560",
};

export const Small = Template.bind({});
Small.args = {
	bgColor: "#4a4a4a",
	category: "small",
	src: "https://kream-phinf.pstatic.net/MjAyMjAxMTFfMjA1/MDAxNjQxODkwNjY5NDI5.6NPmF_WbPm9sX5lW9BE2PcQlkMRAvFxDy7bryYVsDc4g.8YA62__XKcpRvDp-m3k22k1ib0Larluka04T22wL2Ycg.PNG/a_586211b5374344ffa601d2379799d0f0.png",
};
