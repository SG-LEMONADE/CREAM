import React, { FunctionComponent, useEffect } from "react";

import styled from "@emotion/styled";

type ProductDetail = {
	modelNum: string;
	releasedAt: string;
	color: string;
	price: number;
};

const ProductDetail: FunctionComponent<ProductDetail> = (props) => {
	const { modelNum, releasedAt, color, price } = props;

	return (
		<ProductDetailWrapper>
			<DetailTitle>상품정보</DetailTitle>
			<DetailWrapper>
				<StyledDl>
					<StyledModelNum>
						<StyledDt>모델번호</StyledDt>
						<StyledDd style={{ fontWeight: "600" }}>{modelNum}</StyledDd>
					</StyledModelNum>
					<StyledDetailBox>
						<StyledDt>출시일</StyledDt>
						<StyledDd>
							{releasedAt.substring(0, 2)}/{releasedAt.substring(2, 4)}/
							{releasedAt.substring(4)}
						</StyledDd>
						<StyledDd></StyledDd>
					</StyledDetailBox>
					<StyledDetailBox>
						<StyledDt>컬러</StyledDt>
						<StyledDd>{color}</StyledDd>
					</StyledDetailBox>
					<StyledDetailBox>
						<StyledDt>발매가</StyledDt>
						<StyledDd>{price.toLocaleString()}원</StyledDd>
					</StyledDetailBox>
				</StyledDl>
			</DetailWrapper>
		</ProductDetailWrapper>
	);
};

export default ProductDetail;

const ProductDetailWrapper = styled.div`
	margin: 0;
	padding: 0;
`;

const DetailTitle = styled.h3`
	line-height: 22px;
	padding: 39px 0 0px;
	font-size: 18px;
	letter-spacing: -0.27px;
	letter-spacing: -0.15px;
`;

const DetailWrapper = styled.div`
	border: 1px solid #ebebeb;
	border-width: 1px 0;
`;

const StyledDl = styled.dl`
	display: flex;
	min-height: 20px;
	padding-top: 20px;
	padding-bottom: 20px;
`;

const StyledModelNum = styled.div`
	flex: 1;
	padding: 0 12px;
`;

const StyledDetailBox = styled.div`
	border-left: 1px solid #ebebeb;
	flex: 1;
	padding: 0 12px;
`;

const StyledDt = styled.dt`
	line-height: 14px;
	font-size: 12px;
	letter-spacing: -0.33px;
	color: rgba(34, 34, 34, 0.5);
`;

const StyledDd = styled.dd`
	word-break: break-word;
	line-height: 17px;
	font-size: 14px;
	margin: auto;
	padding-top: 10px;
`;
