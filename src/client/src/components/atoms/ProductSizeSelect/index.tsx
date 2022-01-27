import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import { css } from "@emotion/react";
import Icon from "components/atoms/Icon";

type ProductSizeSelectProps = {
	category: "buy" | "sell" | "wish" | "sizeOnly";
	size: string;
	active?: boolean;
	price?: null | number;
	onClick?: (size: string) => void;
};

const ProductSizeSelect: FunctionComponent<ProductSizeSelectProps> = (
	props,
) => {
	const { category, size, active = false, price, onClick } = props;

	const onHandleClick = () => {
		onClick(size);
	};

	return (
		<ShoeSizeWrapper onClick={onHandleClick} category={category}>
			<ShoeSizeBtn active={active}>
				<LinkInner>
					<SizeSpan active={active}>{size}</SizeSpan>
					{(category === "buy" || category === "sell") && (
						<PriceSpan category={category} active={active}>
							{price !== null ? (
								`${price.toLocaleString()}원`
							) : (
								<NonPrice>구매 입찰</NonPrice>
							)}
						</PriceSpan>
					)}
					{category === "wish" && (
						<IconWrapper>
							{active ? (
								<Icon
									style={{
										width: "14px",
										height: "14px",
									}}
									name="BookmarkFilled"
								/>
							) : (
								<Icon
									style={{
										width: "14px",
										height: "14px",
									}}
									name="Bookmark"
								/>
							)}
						</IconWrapper>
					)}
					{category === "sizeOnly" && ``}
				</LinkInner>
			</ShoeSizeBtn>
		</ShoeSizeWrapper>
	);
};

export default ProductSizeSelect;

const ShoeSizeWrapper = styled.li<{ category: string }>`
	list-style: none;
	height: ${({ category }) => (category !== "wish" ? "60px" : "52px")};
`;

const ShoeSizeBtn = styled.button<{ active: boolean }>`
	border-color: ${({ active }) => (active ? "#222" : "#ebebeb")};
	background-color: #fff;
	border-style: solid;
	border-radius: 10px;
	width: 100%;
	height: 100%;
	cursor: pointer;
`;

const LinkInner = styled.div`
	margin: 0 auto;
	max-width: 90px;
	padding: 0;
`;

const SizeSpan = styled.span<{ active: boolean }>`
	display: block;
	line-height: 17px;
	margin-top: -3px;
	font-size: 14px;
	${({ active }) =>
		active &&
		css`
			font-weight: 700;
		`}
`;

const PriceSpan = styled.span<{ category: string; active: boolean }>`
	color: ${({ category }) => (category === "buy" ? "#f15746" : "#31b46e")};
	display: block;
	line-height: 14px;
	margin-top: 2px;
	font-size: 12px;
	${({ active }) =>
		active &&
		css`
			font-weight: 700;
		`}
`;

const NonPrice = styled.span`
	color: black;
`;

const IconWrapper = styled.div``;
