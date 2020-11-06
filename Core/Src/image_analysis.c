/*
 * image_analysis.c
 *
 *  Created on: Nov 6, 2020
 *      Author: Baptiste Rossigneux & Axel Farrugia
 */

#include <stdint.h>

void Draw_Blue_Cross(int x, int y, int thickness, uint16_t* photo_buffer){
	//Horizontal blue line
	if(y < thickness) y = thickness;
	for(int i=0; i<320;i++){
		for(int j=-thickness; j<thickness; j++){
			photo_buffer[((y+j)*320)+i] = 0x001F;
		}
	}
	//Vertical blue line
	for(int i=0; i<240;i++){
	  for(int j=-thickness; j<thickness; j++){
		  photo_buffer[(x+j)+(320*i)] = 0x001F;
	  }
	}
}
