import React, { FunctionComponent } from "react";

import BannerImage from "components/atoms/BannerImage";
import Slider from "components/organisms/Slider";

import styled from "@emotion/styled";
import Shortcuts from "components/molecules/Shortcuts";

type HomeTemplateProps = {
	children: React.ReactNode;
};

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

const HomeTemplate: FunctionComponent<HomeTemplateProps> = (props) => {
	const { children } = props;

	return (
		<HomeTemplateWrapper>
			<Slider images={bigList} />
			<ShortcutCollection>
				<Shortcuts />
			</ShortcutCollection>
			{children}
		</HomeTemplateWrapper>
	);
};

export default HomeTemplate;

const HomeTemplateWrapper = styled.div`
	position: relative;
	padding-top: 100px;
	overflow-anchor: none;
`;

const ShortcutCollection = styled.section`
	margin-top: 50px;
	padding-top: 0;
	padding-bottom: 0;
`;
