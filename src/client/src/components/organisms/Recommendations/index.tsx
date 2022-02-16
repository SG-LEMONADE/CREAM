import React, { FunctionComponent, useContext } from "react";

import CollectionTitle from "components/atoms/CollectionTitle";
import ProductThumbnail from "components/organisms/ProductThumbnail";

import styled from "@emotion/styled";
import { HomeProductInfoRes } from "types";
import UserContext from "context/user";

type RecommendationsProps = {
	productInfos: HomeProductInfoRes[];
	onHandleWishClick: (selectedProduct?: HomeProductInfoRes) => void;
};

const Recommendations: FunctionComponent<RecommendationsProps> = (props) => {
	const { user } = useContext(UserContext);

	const { productInfos, onHandleWishClick } = props;

	return (
		<RecommendationWrapper>
			<ProductArea>
				<TitleArea>
					<CollectionTitle
						title="Only for YOU 🎁"
						subTitle="당신만을 위한 추천 상품 🎁"
					/>
				</TitleArea>
				<ProductsWrapper>
					<ProductsImageArea>
						{productInfos.length > 0 ? (
							productInfos.map((product) => (
								<ProductThumbnail
									key={product.id}
									category="home"
									minWidthMode={true}
									productInfo={product}
									isWishState={
										product.wishList !== null
											? product.wishList.length > 0
											: false
									}
									onHandleWishClick={() => onHandleWishClick(product)}
								/>
							))
						) : (
							<EmptyContents>
								{user ? (
									<>
										<StyledAlarmTitle>
											추천해줄 아이템이 아직 없어요. 😓
										</StyledAlarmTitle>
										<StyledAlarmSubTitle>
											조금만 더 관심있는 제품 둘러보고 오시면 추천해드릴게요! 😝
										</StyledAlarmSubTitle>
									</>
								) : (
									<>
										<StyledAlarmTitle>
											추천 서비스를 받기 위해서는 로그인이 필요해요! 🤔
										</StyledAlarmTitle>
										<StyledAlarmSubTitle>
											로그인 후 서비스 이용 부탁드려요. 🤗
										</StyledAlarmSubTitle>
									</>
								)}
							</EmptyContents>
						)}
					</ProductsImageArea>
				</ProductsWrapper>
			</ProductArea>
		</RecommendationWrapper>
	);
};

export default Recommendations;

const RecommendationWrapper = styled.section`
	margin: 10px 0;
`;

const ProductArea = styled.div`
	margin-top: 30px;
	@media screen and (max-width: 1400px) {
		padding: 0 40px;
	}
`;

const TitleArea = styled.div`
	max-width: 1280px;
	margin: 0 auto;
`;

const ProductsWrapper = styled.div`
	max-width: 1280px;
	margin: 0 auto;
	/* overflow-anchor: none; */
`;

const ProductsImageArea = styled.div`
	overflow-x: scroll;
	position: relative;
	margin: 20px auto;
	width: 100%;
	display: flex;
`;

const EmptyContents = styled.div`
	margin: 45px auto;
`;

const StyledAlarmTitle = styled.p`
	font-size: 18px;
	color: rgba(34, 34, 34, 0.8);
	text-align: center;
`;

const StyledAlarmSubTitle = styled.p`
	font-size: 15px;
	color: rgba(34, 34, 34, 0.8);
	text-align: center;
`;
