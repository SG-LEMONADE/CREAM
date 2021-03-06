import React, { FunctionComponent, useContext } from "react";
import UserContext from "context/user";

import CollectionTitle from "components/atoms/CollectionTitle";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import { HomeProductInfoRes } from "types";

import styled from "@emotion/styled";

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
						title="Only for YOU π"
						subTitle="λΉμ λ§μ μν μΆμ² μν π"
					/>
					<ExtraText>μ’μ°λ‘ μ€ν¬λ‘€νμ¬ μΆμ²λ μνμ νμΈνμΈμ π</ExtraText>
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
											μΆμ²ν΄μ€ μμ΄νμ΄ μμ§ μμ΄μ. π
										</StyledAlarmTitle>
										<StyledAlarmSubTitle>
											μ‘°κΈλ§ λ κ΄μ¬μλ μ ν λλ¬λ³΄κ³  μ€μλ©΄ μΆμ²ν΄λλ¦΄κ²μ! π
										</StyledAlarmSubTitle>
									</>
								) : (
									<>
										<StyledAlarmTitle>
											μΆμ² μλΉμ€λ₯Ό λ°κΈ° μν΄μλ λ‘κ·ΈμΈμ΄ νμν΄μ! π€
										</StyledAlarmTitle>
										<StyledAlarmSubTitle>
											λ‘κ·ΈμΈ ν μλΉμ€ μ΄μ© λΆνλλ €μ. π€
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
	position: relative;
`;

const ExtraText = styled.p`
	margin: 0;
	padding: 0;
	position: absolute;
	right: 0;
	bottom: 0;
	right: 3px;
	color: rgba(34, 34, 34, 0.5);
	font-size: 13.5px;
	letter-spacing: -0.31px;
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
