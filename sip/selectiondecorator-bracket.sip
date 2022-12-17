/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPSelectionDecoratorBracket : public QCPSelectionDecorator /NoDefaultCtors/
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum BracketStyle { bsSquareBracket ///< A square bracket is drawn.
                      ,bsHalfEllipse   ///< A half ellipse is drawn. The size of the ellipse is given by the bracket width/height properties.
                      ,bsEllipse       ///< An ellipse is drawn. The size of the ellipse is given by the bracket width/height properties.
                      ,bsPlus         ///< A plus is drawn.
                      ,bsUserStyle    ///< Start custom bracket styles at this index when subclassing and reimplementing \ref drawBracket.
  };
  
  QCPSelectionDecoratorBracket();
  virtual ~QCPSelectionDecoratorBracket();
  
  // getters:
  QPen bracketPen() const;
  QBrush bracketBrush() const;
  int bracketWidth() const;
  int bracketHeight() const;
  BracketStyle bracketStyle() const;
  bool tangentToData() const;
  int tangentAverage() const;
  
  // setters:
  void setBracketPen(const QPen &pen);
  void setBracketBrush(const QBrush &brush);
  void setBracketWidth(int width);
  void setBracketHeight(int height);
  void setBracketStyle(BracketStyle style);
  void setTangentToData(bool enabled);
  void setTangentAverage(int pointCount);
  
  // introduced virtual methods:
  virtual void drawBracket(QCPPainter *painter, int direction) const;
  
  // virtual methods:
  virtual void drawDecoration(QCPPainter *painter, QCPDataSelection selection);

protected:
  // non-virtual methods:
  double getTangentAngle(const QCPPlottableInterface1D *interface1d, int dataIndex, int direction) const;
  QPointF getPixelCoordinates(const QCPPlottableInterface1D *interface1d, int dataIndex) const;

private:
  QCPSelectionDecoratorBracket(const QCPSelectionDecoratorBracket&);
  QCPSelectionDecoratorBracket& operator=(const QCPSelectionDecoratorBracket&);
};
