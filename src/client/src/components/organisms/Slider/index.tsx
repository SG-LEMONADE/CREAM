import React, { FunctionComponent } from "react";
import { Zoom, Fade } from "react-slideshow-image";

import Icon from "components/atoms/Icon";
import BannerImage from "components/atoms/BannerImage";

import "react-slideshow-image/dist/styles.css";
import styled from "@emotion/styled";

type SliderProps = {
	productSlider?: boolean;
	small?: boolean;
	images: typeof BannerImage[];
};

const Slider: FunctionComponent<SliderProps> = (props) => {
	const { productSlider = false, small = false, images } = props;

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
					width: "10px",
				}}
			/>
		),
		nextArrow: (
			<Icon
				name="ChevronRight"
				style={{
					marginLeft: "-30px",
					zIndex: "99",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
	};

	const productProperties = {
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
					width: "10px",
				}}
			/>
		),
		nextArrow: (
			<Icon
				name="ChevronRight"
				style={{
					marginLeft: "-30px",
					zIndex: "99",
					cursor: "pointer",
					width: "10px",
				}}
			/>
		),
		scale: 1.5,
	};

	return (
		<>
			{productSlider ? (
				<StyledSlider {...productProperties}>
					{images.map((Image, index) => (
						<div key={index} className="each-slide">
							<>{Image}</>
						</div>
					))}
				</StyledSlider>
			) : (
				<StyledFade small={small} {...properties}>
					{images.map((Image, index) => (
						<div key={index} className="each-fade">
							<>{Image}</>
						</div>
					))}
				</StyledFade>
			)}
		</>
	);
};

export default Slider;

const StyledFade = styled(Fade)<{ small: boolean }>`
	max-width: ${({ small }) => small && "1200px"};
`;

const StyledSlider = styled(Zoom)`
	max-width: 560px;
`;
