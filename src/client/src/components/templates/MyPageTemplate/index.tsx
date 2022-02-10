import React, { FunctionComponent } from "react";
import Link from "next/link";

import MyPageSidebar from "components/organisms/MyPageSidebar";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import Icon from "components/atoms/Icon";
import { ProductInfoRes } from "types";

import styled from "@emotion/styled";

type MyPageTemplateProps = {
	children: React.ReactNode;
	wishProducts?: ProductInfoRes[];
};

const MyPageTemplate: FunctionComponent<MyPageTemplateProps> = (props) => {
	const { children, wishProducts } = props;

	return (
		<MyPageTemplateWrapper>
			<SideNavBarArea>
				<MyPageSidebar />
			</SideNavBarArea>
			<ContentsWrapper>
				{children}
				<WishProductWrapper>
					<StyledTitle>
						<StyledH3>관심 상품</StyledH3>
						<Link href={`/my/wish`}>
							<MoreLink>
								더보기
								<Icon
									name="ChevronRight"
									style={{ width: "15px", height: "15px", marginLeft: "5px" }}
								/>
							</MoreLink>
						</Link>
					</StyledTitle>
					<WishProductGrid>
						{wishProducts &&
							wishProducts.length > 0 &&
							wishProducts.map((product) => (
								<ProductThumbnail
									key={product.id}
									category="product"
									productInfo={product}
								/>
							))}
					</WishProductGrid>
				</WishProductWrapper>
			</ContentsWrapper>
		</MyPageTemplateWrapper>
	);
};

export default MyPageTemplate;

const MyPageTemplateWrapper = styled.div`
	margin: 0 auto;
	margin-top: 100px;
	padding: 40px 40px 160px;
	max-width: 1280px;
`;

const SideNavBarArea = styled.div`
	float: left;
	width: 180px;
	margin-right: 20px;
`;

const ContentsWrapper = styled.div`
	overflow: hidden;
	min-height: 380px;
`;

const WishProductWrapper = styled.div``;

const StyledTitle = styled.div`
	margin-top: 42px;
	padding-bottom: 16px;
	display: flex;
	max-width: 100%;
`;

const StyledH3 = styled.h3`
	font-size: 18px;
	letter-spacing: -0.27px;
`;

const MoreLink = styled.a`
	margin-top: -2px;
	margin-left: auto;
	padding: 3px 0 3px 5px;
	display: inline-flex;
	align-items: center;
	flex-shrink: 0;
	color: rgba(34, 34, 34, 0.5);
	line-height: 20px;
	font-size: 13px;
	letter-spacing: -0.07px;
	font-weight: 400;
	cursor: pointer;
`;

const WishProductGrid = styled.div`
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
`;
