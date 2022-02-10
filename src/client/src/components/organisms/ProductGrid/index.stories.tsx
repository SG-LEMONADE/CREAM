import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductGrid from ".";

export default {
	title: "organisms/ProductGrid",
	component: ProductGrid,
} as ComponentMeta<typeof ProductGrid>;

const Template: ComponentStory<typeof ProductGrid> = (args) => (
	<ProductGrid {...args}>{args.children}</ProductGrid>
);

export const Default = Template.bind({});
Default.args = {
	products: [
		{
			backgroundColor: "#f4f4f4",
			brandName: "Polo Ralph Lauren",
			category: "streetwear",
			color: "gray",
			gender: "unisex",
			highestBid: 1,
			id: 1,
			imageUrls: [
				"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
			],
			lowestAsk: 1,
			originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
			originalPrice: 200000,
			premiumPrice: 200000,
			releasedDate: "20200110",
			sizes: "",
			styleCode: "",
			totalSale: 1,
			translatedName: "어쩌구",
			wishCnt: 12,
			wishList: ["1"],
		},
		{
			backgroundColor: "#f4f4f4",
			brandName: "Polo Ralph Lauren",
			category: "streetwear",
			color: "gray",
			gender: "unisex",
			highestBid: 1,
			id: 1,
			imageUrls: [
				"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
			],
			lowestAsk: 1,
			originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
			originalPrice: 200000,
			premiumPrice: 200000,
			releasedDate: "20200110",
			sizes: "",
			styleCode: "",
			totalSale: 1,
			translatedName: "어쩌구",
			wishCnt: 12,
			wishList: ["1"],
		},
		{
			backgroundColor: "#f4f4f4",
			brandName: "Polo Ralph Lauren",
			category: "streetwear",
			color: "gray",
			gender: "unisex",
			highestBid: 1,
			id: 1,
			imageUrls: [
				"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
			],
			lowestAsk: 1,
			originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
			originalPrice: 200000,
			premiumPrice: 200000,
			releasedDate: "20200110",
			sizes: "",
			styleCode: "",
			totalSale: 1,
			translatedName: "어쩌구",
			wishCnt: 12,
			wishList: ["1"],
		},
		{
			backgroundColor: "#f4f4f4",
			brandName: "Polo Ralph Lauren",
			category: "streetwear",
			color: "gray",
			gender: "unisex",
			highestBid: 1,
			id: 1,
			imageUrls: [
				"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
			],
			lowestAsk: 1,
			originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
			originalPrice: 200000,
			premiumPrice: 200000,
			releasedDate: "20200110",
			sizes: "",
			styleCode: "",
			totalSale: 1,
			translatedName: "어쩌구",
			wishCnt: 12,
			wishList: ["1"],
		},
		{
			backgroundColor: "#f4f4f4",
			brandName: "Polo Ralph Lauren",
			category: "streetwear",
			color: "gray",
			gender: "unisex",
			highestBid: 1,
			id: 1,
			imageUrls: [
				"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
			],
			lowestAsk: 1,
			originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
			originalPrice: 200000,
			premiumPrice: 200000,
			releasedDate: "20200110",
			sizes: "",
			styleCode: "",
			totalSale: 1,
			translatedName: "어쩌구",
			wishCnt: 12,
			wishList: ["1"],
		},
	],
};
