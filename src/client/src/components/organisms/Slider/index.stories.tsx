import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Slider from "./";
import BannerImage from "components/atoms/BannerImage";
import ProductImage from "components/atoms/ProductImage";

const bigList = [
	<BannerImage
		bgColor="rgb(249, 249, 249)"
		category="big"
		src="https://kream-phinf.pstatic.net/MjAyMDExMjNfMjU0/MDAxNjA2MTAxMjMwOTg2.Lru1_LSFReeOGavo_Nv5iHAHEQDrgcRVuUDO_VwQbL0g.if4WbmNvghR7rUXR_MxttP9QrAVnboaK1IAxnaF0d6kg.JPEG/p_e1a64ddc68fe4c16b7e2390ee5daa6f4.jpg?type=m_2560"
	/>,
	<BannerImage
		bgColor="rgb(63, 122, 119)"
		category="big"
		src="https://kream-phinf.pstatic.net/MjAyMjAxMDdfMTk5/MDAxNjQxNTQ0MTc4NzIz._lnD2aDIb8d17AtwRk2xFkW3lRQn_NhvTbQHZRu0WYgg.EU-x1wsA98qBb1o3o6ohduLqHkxwPreUr0KuVhnuwGkg.PNG/a_b0dc85e9b4a14b5cbfccad585a707332.png?type=m_2560"
	/>,
];

const smallList = [
	<BannerImage
		bgColor="#4a4a4a"
		category="small"
		src="https://kream-phinf.pstatic.net/MjAyMjAxMTFfMjA1/MDAxNjQxODkwNjY5NDI5.6NPmF_WbPm9sX5lW9BE2PcQlkMRAvFxDy7bryYVsDc4g.8YA62__XKcpRvDp-m3k22k1ib0Larluka04T22wL2Ycg.PNG/a_586211b5374344ffa601d2379799d0f0.png"
	/>,
	<BannerImage
		bgColor="#0CB459"
		category="small"
		src="https://kream-phinf.pstatic.net/MjAyMTExMDhfMTQg/MDAxNjM2MzUyODQ4MTAy.Cw85PX23DLnCC0JXxlf5uRR4V6OUxDsz12MQLHRVeXsg.xdWI38nU5YX5e8cq6zifnXghc7o6Jl26o0U_vV7QVbkg.PNG/a_4e25f1b123af4f79ab8eb2c243321230.png"
	/>,
	<BannerImage
		bgColor="#ECE3F4"
		category="small"
		src="https://kream-phinf.pstatic.net/MjAyMTA4MTBfMTM0/MDAxNjI4NTM2NzQwNzI2.PFukx8j7Xo8kbhUCYJNc8Vx8wsQObtdjh0E3qCLbpq8g.0_OMaQNb714BoMvFdCXQsEMNSbYtD2WvNW-0-v8iHLcg.JPEG/a_499eb6d55b8c4e71b32e909bb1586e10.jpg"
	/>,
	<BannerImage
		bgColor="#3C31BB"
		category="small"
		src="https://kream-phinf.pstatic.net/MjAyMTA4MDJfMjg2/MDAxNjI3ODg3NjYxMjc0.qPz4jY6pgcqhai_G23z-Iwa-Z5jcp-fYj1OKVEMpAzog.ntI1W2Fy8KutXWMUSzW6gXb9b5_cMc0DZ6WEBAXJenAg.JPEG/p_7766440af0194c368eaf4c6dd1f4a9c9.jpg"
	/>,
];

const productSlider = [
	<ProductImage
		src="https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=l"
		category="products"
		backgroundColor="rgb(235, 240, 245)"
	/>,
	<ProductImage
		src="https://kream-phinf.pstatic.net/MjAyMTA3MjhfMTk2/MDAxNjI3NDQxMDEwNTc1.OVWeJtFIWhzmfjmKBH7islcWu25BA5kRgCum0NefxiEg.3-WlGTrUGQIqwMLUquLu-qbwAm4MAazH2vAwDr9DB8sg.PNG/p_21b22bba768a49378b071d15fe3671c7.png?type=l"
		category="products"
		backgroundColor="rgb(235, 240, 245)"
	/>,
	<ProductImage
		src="https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjQx/MDAxNjI3NDQxMDEyMjA2.DcysBFreA7tuLaKgU7UyPWct_NH87Ad9ktvGmEmaXjUg.VFp5d9BX5YPB-h6fGruYOUDXGrz_UPXrJWnPANfhhJAg.PNG/p_8d86fe659c3542b2aaafa40a7a0048c1.png?type=l"
		category="products"
		backgroundColor="rgb(235, 240, 245)"
	/>,
];

export default {
	title: "organisms/Slider",
	component: Slider,
} as ComponentMeta<typeof Slider>;

const Template: ComponentStory<typeof Slider> = (args) => (
	<Slider {...args}>{args.children}</Slider>
);

export const BigSlider = Template.bind({});
BigSlider.args = {
	images: bigList,
};

export const SmallSlider = Template.bind({});
SmallSlider.args = {
	small: true,
	images: smallList,
};

export const ProductSlider = Template.bind({});
ProductSlider.args = {
	productSlider: true,
	images: productSlider,
};
