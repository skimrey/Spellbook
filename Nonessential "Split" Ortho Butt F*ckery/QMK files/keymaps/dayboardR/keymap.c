/* Copyright 2020 Solomon Kimrey
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

// Defines names for use in layer keycodes and the keymap

// Defines the keycodes used by our macros in process_record_user
enum custom_keycodes {
    QMKBEST = SAFE_RANGE,
    QMKURL
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Base */
    [0] = LAYOUT( \
    KC_ESC, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0, KC_MINS, KC_MINS, KC_EQUAL, KC_BSPACE, \
    KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_LBRACKET, KC_RBRACKET, KC_SLASH, DF(1), \
    KC_F1, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_P, KC_QUOTE, KC_ENTER, KC_QUOTE, DF(1), \
    KC_LSHIFT, KC_Z, KC_X, KC_C, KC_V, KC_V, KC_B, KC_N, KC_M, KC_COMMA, KC_DOT, KC_RSHIFT, KC_SLASH, KC_UP, KC_UP, \
    KC_LCTRL, KC_LGUI, KC_LALT, KC_SPACE, KC_TAB, KC_B, KC_N, KC_M, KC_M, KC_RGUI, KC_F1, KC_RCTRL, KC_LEFT, KC_DOWN, KC_RIGHT  \
    ),
    [1] = LAYOUT( \
    MI_B_3, MI_C_4, MI_Cs_4, MI_D_4, MI_Ds_4, MI_E_4, MI_F_4, MI_Fs_4, MI_G_4, MI_Gs_4, MI_A_4, MI_As_4, MI_B_4, MI_C_5, MI_Cs_5, \
    MI_G_3, MI_Gs_3, MI_A_3, MI_As_3, MI_B_3, MI_C_4, MI_Cs_4, MI_D_4, MI_Ds_4, MI_E_4, MI_F_4, MI_Fs_4, MI_G_4, MI_Gs_4, DF(2), \
    MI_D_3, MI_Ds_3, MI_E_3, MI_F_3, MI_Fs_3, MI_G_3, MI_Gs_3, MI_A_3, MI_As_3, MI_B_3, MI_C_4, MI_Cs_4, MI_D_4, MI_Ds_4, DF(2), \
    MI_A_2, MI_As_2, MI_B_2, MI_C_3, MI_Cs_3, MI_D_3, MI_Ds_3, MI_E_3, MI_F_3, MI_Fs_3, MI_G_3, MI_Gs_3, MI_A_3, MI_As_3, MI_OCTU, \
    MI_E_2, MI_F_2, MI_Fs_2, MI_G_2, MI_Gs_2, MI_A_2, MI_As_2, MI_B_2, MI_C_3, MI_Cs_3, MI_D_3, MI_Ds_3, MI_E_3, MI_F_3, MI_OCTD  \
    ),
    [2] = LAYOUT( \
    KC_ESC, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0, KC_MINS, KC_EQUAL, KC_0, KC_BSPACE, \
    KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_LBRACKET, KC_RBRACKET, KC_SLASH, DF(0), \
    KC_LSHIFT, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCOLON, KC_LBRACKET, KC_QUOTE, KC_ENTER, DF(0), \
    KC_LSHIFT, KC_Z, KC_X, KC_C, KC_V, KC_V, KC_B, KC_N, KC_M, KC_COMMA, KC_DOT,  KC_QUOTE,  KC_QUOTE, KC_SLASH, KC_UP, \
    KC_LCTRL, KC_LGUI, KC_LALT, KC_C, KC_C, KC_H, KC_N, KC_M, KC_H, KC_RGUI, KC_RCTRL, MI_Ds_3, KC_LEFT, KC_DOWN, KC_RIGHT  \
    )  
};


/*
void matrix_init_user(void) {

}

void matrix_scan_user(void) {

}

bool led_update_user(led_t led_state) {
    return true;
}
*/
