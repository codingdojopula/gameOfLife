package hr.codingdojo.puls.gol.mstipanov;

import hr.codingdojo.puls.gol.mstipanov.ui.impl.GameOfLifePanel;

/**
 * @author mstipanov
 * @since 04.12.11. 18:37
 */
public class GameOfLife {
    public static void main(String[] args) {
        GameOfLifeController gameOfLifeController = new GameOfLifeController();

        GameOfLifePanel gameOfLifePanel = new GameOfLifePanel(gameOfLifeController);
        gameOfLifePanel.show();

        gameOfLifeController.setGameOfLifePresenter(gameOfLifePanel);
        gameOfLifeController.clear();
    }
}
