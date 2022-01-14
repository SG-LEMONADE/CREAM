import React, { FunctionComponent } from "react";
import { Fade } from "react-slideshow-image";

import Icon from "components/atoms/Icon";
import BannerImage from "components/atoms/BannerImage";

import "react-slideshow-image/dist/styles.css";
import styled from "@emotion/styled";

type SliderProps = {
	small?: boolean;
	images: typeof BannerImage[];
};

const Slider: FunctionComponent<SliderProps> = (props) => {
	const { small = false, images } = props;

	const properties = {
		duration: 4000,
		transitionDuration: 400,
		infinite: true,
		prevArrow: (
			<Icon
				name="ChevronLeft"
				style={{
					marginRight: "-30px",
					zIndex: "99",
					cursor: "pointer",
				}}
			/>
		),
		nextArrow: (
			<Icon
				name="ChevronRight"
				style={{ marginLeft: "-30px", zIndex: "99", cursor: "pointer" }}
			/>
		),
	};

	return (
		<StyledFade small={small} {...properties}>
			{images.map((Image, index) => (
				<div key={index} className="each-fade">
					<>{Image}</>
				</div>
			))}
		</StyledFade>
	);
};

export default Slider;

const StyledFade = styled(Fade)<{ small: boolean }>`
	max-width: ${({ small }) => small && "1200px"};
`;
