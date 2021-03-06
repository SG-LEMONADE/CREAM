import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Icon from "components/atoms/Icon";

type SizeSelectProps = {
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<SVGSVGElement>;
};

const SizeSelect: FunctionComponent<SizeSelectProps> = (props) => {
	const { onClick, children } = props;

	return (
		<SizeSelectWrapper>
			<StyledTitle>
				<StyledSpan>사이즈</StyledSpan>
			</StyledTitle>
			<StyledSize>
				<StyledModalBtn>
					<StyledSizeSpan>{children}</StyledSizeSpan>
					<Icon
						onClick={onClick}
						name="ChevronDown"
						style={{ width: "20px", height: "20px" }}
					/>
				</StyledModalBtn>
			</StyledSize>
		</SizeSelectWrapper>
	);
};

export default SizeSelect;

const SizeSelectWrapper = styled.div`
	padding-top: 19px;
	padding-bottom: 12px;
	border-bottom: 1px solid #ebebeb;
	display: flex;
	justify-content: space-between;
`;

const StyledTitle = styled.div``;

const StyledSpan = styled.span`
	padding-top: 4px;
	display: inline-block;
	line-height: 16px;
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.8);
`;

const StyledSize = styled.div``;

const StyledModalBtn = styled.div`
	cursor: pointer;
`;

const StyledSizeSpan = styled.span`
	vertical-align: top;
	display: inlin-blck;
	margin-right: 5px;
`;
