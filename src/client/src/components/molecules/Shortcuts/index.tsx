import styled from "@emotion/styled";
import ShortcutItem from "components/atoms/ShortcutItem";
import React, { FunctionComponent } from "react";
import { ShortcutItemRes } from "types";

type ShortcutsProps = {
	items?: ShortcutItemRes[];
};

const Shortcuts: FunctionComponent<ShortcutsProps> = (props) => {
	const { items } = props;
	return (
		<StyledShortcutWrapper>
			{items ? (
				items.map((item) => (
					<ShortcutItem link={item.link} src={item.image} title={item.title} />
				))
			) : (
				<>
					<ShortcutItem
						link={"/"}
						src="https://kream-phinf.pstatic.net/MjAyMjAxMTRfODIg/MDAxNjQyMTU4OTI4NTMw.7_sAnOgUFxUyKVkQgepQp2DWk8pVXpm_xl7LJqAEz1og.7SLCSPjC2IQL4t1trFDzAk3mNvxxYD30jdWVCPIcQmQg.GIF/a_248a7191e7d042e98446f5d2e4fe0c07.gif?type=m"
						title="프리미엄"
					/>
					<ShortcutItem
						link={"/"}
						src="https://kream-phinf.pstatic.net/MjAyMjAxMTRfNjUg/MDAxNjQyMTU5MDU3NjQ0.6UT2n2TIBXaZrTsANX0jzD5MnAlhGFJoa_1hUk9LuJQg.zgj4FNXPburxIqL7FNfXqoakZwwiYZFZl67ThkiIPxgg.JPEG/a_390f944c3af843598e9e7a887ec1d4ad.jpg?type=m"
						title="겨울 아우터"
					/>
					<ShortcutItem
						link={"/"}
						src="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMjE1/MDAxNjQyMTU5MDkzMTA5.jYkIpHR1COueflqCn8Yw55IAHUqU5RldYcwvdOMqfiQg.l21Ywj_7dr7jBm0le5abUnD_Linotl-nFlnHuJ-QK9sg.JPEG/a_3c5bbf01cda2437d9c3d3576f817b22c.jpg?type=m"
						title="#스타일"
					/>
					<ShortcutItem
						link={"/"}
						src="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMjgw/MDAxNjQyMTU5MTU3NjM5.p89ur4TcB7U6IJLE2GJEMtMfYbCgQwjiPkjccxdsJ3kg.DzCb0EY9KMVSa-bbu9mwwPTP7He_inHbnkz6EXB7x2Mg.JPEG/a_3e2d573f7ab04f319d05837caa8ccf2c.jpg?type=m"
						title="럭키 드로우"
					/>
					<ShortcutItem
						link={"/"}
						src="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTQz/MDAxNjQyMTU5MjAzMTky.gBmTPr0MuTH3Gb-lzKETZZeR5mL4N0wrNMxPYYsFWPMg.iw9vitAc87EJMgJyYAueUKUMtMW8Vz4lhg_LfMXYUecg.JPEG/a_8118c64019764004be4134ea4c03f1f2.jpg?type=m"
						title="빠른 배송"
					/>
				</>
			)}
		</StyledShortcutWrapper>
	);
};

export default Shortcuts;

const StyledShortcutWrapper = styled.section`
	margin: 20px auto 0;
	padding: 0 32.5px;
	max-width: 1280px;
	padding: 0 0 20px;
`;
