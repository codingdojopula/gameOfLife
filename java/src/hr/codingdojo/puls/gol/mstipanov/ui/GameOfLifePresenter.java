package hr.codingdojo.puls.gol.mstipanov.ui;

import hr.codingdojo.puls.gol.mstipanov.Cell;

/**
 * @author mstipanov
 * @since 04.12.11. 18:57
 */
public interface GameOfLifePresenter {
    void draw(Cell[][] cells);

    void show();
}
