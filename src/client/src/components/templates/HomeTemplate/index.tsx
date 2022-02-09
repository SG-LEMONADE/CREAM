import React, { FunctionComponent } from "react";

import BannerImage from "components/atoms/BannerImage";
import Slider from "components/organisms/Slider";

import styled from "@emotion/styled";
import Shortcuts from "components/molecules/Shortcuts";

type HomeTemplateProps = {
	isLoading?: boolean;
	ads?: { backgroundColor: string; imageUrl: string }[];
	children: React.ReactNode;
};

const bigList = [
	<BannerImage
		bgColor="#f6f6ee"
		category="big"
		src="https://kream-phinf.pstatic.net/MjAyMjAxMjhfMjk0/MDAxNjQzMzM5MjYzODU1.cdlMQx38vTgTq7Gv7x6aUUtInzvEE_dzkyl4nNA2NwYg.W771A2Ma7g0bdKe9V_vTjBAbVDorcXhpqJp4bP2Aemsg.PNG/a_84e730df26b0461a958b47a868a6e047.png?type=m_2560"
	/>,
	<BannerImage
		bgColor="rgb(63, 122, 119)"
		category="big"
		src="https://kream-phinf.pstatic.net/MjAyMjAxMDdfMTk5/MDAxNjQxNTQ0MTc4NzIz._lnD2aDIb8d17AtwRk2xFkW3lRQn_NhvTbQHZRu0WYgg.EU-x1wsA98qBb1o3o6ohduLqHkxwPreUr0KuVhnuwGkg.PNG/a_b0dc85e9b4a14b5cbfccad585a707332.png?type=m_2560"
	/>,
];

const HomeTemplate: FunctionComponent<HomeTemplateProps> = (props) => {
	const { children, ads, isLoading = false } = props;

	return (
		<HomeTemplateWrapper>
			<Slider
				images={
					ads
						? ads.map((ad) => (
								<BannerImage
									bgColor={ad.backgroundColor}
									category="big"
									src={ad.imageUrl}
								/>
						  ))
						: bigList
				}
			/>
			<ShortcutCollection>
				<Shortcuts />
			</ShortcutCollection>
			{isLoading ? <LoadingWrapper>{children}</LoadingWrapper> : children}
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

const LoadingWrapper = styled.div`
	display: flex;
	margin: 120px 0;
	justify-content: center;
	align-items: center;
`;
